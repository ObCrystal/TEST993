"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Search, Download, Users, Star, TrendingUp, Gamepad2, Settings, User } from 'lucide-react'

const featuredGames = [
  {
    id: 1,
    title: "Adopt Me!",
    description: "Raise and dress up cute pets, decorate your house, and play with friends!",
    players: "200K+",
    rating: 4.8,
    image:
      "https://tr.rbxcdn.com/30DAY-AvatarHeadshot-A84D436E5E674C24B0A259C5B52F3C3A-Png/150/150/AvatarHeadshot/Png/noFilter",
    category: "Simulation",
    trending: true,
  },
  {
    id: 2,
    title: "Brookhaven RP",
    description: "Welcome to Brookhaven, where you can be anything you want to be!",
    players: "150K+",
    rating: 4.6,
    image: "https://tr.rbxcdn.com/7cd5f12b1d3b5b4c8a9e2f1a3c4d5e6f7g8h9i0j/768/432/Image/Png",
    category: "Roleplay",
    trending: true,
  },
  {
    id: 3,
    title: "Tower of Hell",
    description: "Climb the tower and reach the top! Can you beat the ultimate challenge?",
    players: "80K+",
    rating: 4.5,
    image: "https://tr.rbxcdn.com/1f2e3d4c5b6a7980fed1cba0987654321/768/432/Image/Png",
    category: "Obby",
    trending: false,
  },
  {
    id: 4,
    title: "Arsenal",
    description: "Fast-paced FPS action with unique weapons and competitive gameplay!",
    players: "120K+",
    rating: 4.7,
    image: "https://tr.rbxcdn.com/9a8b7c6d5e4f3210fedcba0987654321/768/432/Image/Png",
    category: "FPS",
    trending: true,
  },
  {
    id: 5,
    title: "Blox Fruits",
    description: "Become the strongest fighter with devil fruits and epic battles!",
    players: "300K+",
    rating: 4.9,
    image: "https://tr.rbxcdn.com/5f4e3d2c1b0a9876543210fedcba0987/768/432/Image/Png",
    category: "Fighting",
    trending: true,
  },
  {
    id: 6,
    title: "Jailbreak",
    description: "Rob banks, escape prison, or stop criminals as a police officer!",
    players: "90K+",
    rating: 4.4,
    image: "https://tr.rbxcdn.com/3c2b1a0987654321fedcba0987654321/768/432/Image/Png",
    category: "Action",
    trending: false,
  },
]

const categories = ["All", "Simulation", "Roleplay", "Obby", "FPS", "Fighting", "Action"]

export default function RobloxGameHub() {
  const [selectedCategory, setSelectedCategory] = useState("All")
  const [searchQuery, setSearchQuery] = useState("")

  const filteredGames = featuredGames.filter((game) => {
    const matchesCategory = selectedCategory === "All" || game.category === selectedCategory
    const matchesSearch =
      game.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      game.description.toLowerCase().includes(searchQuery.toLowerCase())
    return matchesCategory && matchesSearch
  })

  return (
    <div className="min-h-screen bg-background text-foreground">
      {/* Header */}
      <header className="border-b border-border bg-card">
        <div className="container mx-auto px-4 py-3">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <Gamepad2 className="h-6 w-6 text-primary" />
              <h1 className="text-xl font-bold text-balance">Roblox Game Hub</h1>
            </div>
            <div className="flex items-center space-x-2">
              <Button variant="ghost" size="sm">
                <Settings className="h-4 w-4" />
              </Button>
              <Button variant="ghost" size="sm">
                <User className="h-4 w-4" />
              </Button>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-6">
        {/* Search and Filters */}
        <div className="mb-6 flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
          <div className="relative w-full sm:max-w-sm">
            <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input
              placeholder="Search games..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-10"
            />
          </div>

          <div className="flex flex-wrap gap-2">
            {categories.map((category) => (
              <Button
                key={category}
                variant={selectedCategory === category ? "default" : "secondary"}
                size="sm"
                onClick={() => setSelectedCategory(category)}
                className="text-xs px-3 py-1"
              >
                {category}
              </Button>
            ))}
          </div>
        </div>

        {/* Stats Bar */}
        <div className="mb-6 grid grid-cols-3 gap-3">
          <Card className="p-3">
            <CardContent className="flex items-center justify-between p-0">
              <div>
                <p className="text-xs text-muted-foreground">Games</p>
                <p className="text-lg font-bold">{featuredGames.length}</p>
              </div>
              <Gamepad2 className="h-5 w-5 text-primary" />
            </CardContent>
          </Card>
          <Card className="p-3">
            <CardContent className="flex items-center justify-between p-0">
              <div>
                <p className="text-xs text-muted-foreground">Players</p>
                <p className="text-lg font-bold">1.2M+</p>
              </div>
              <Users className="h-5 w-5 text-primary" />
            </CardContent>
          </Card>
          <Card className="p-3">
            <CardContent className="flex items-center justify-between p-0">
              <div>
                <p className="text-xs text-muted-foreground">Trending</p>
                <p className="text-lg font-bold">{featuredGames.filter((g) => g.trending).length}</p>
              </div>
              <TrendingUp className="h-5 w-5 text-primary" />
            </CardContent>
          </Card>
        </div>

        {/* Game Grid */}
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
          {filteredGames.map((game) => (
            <Card
              key={game.id}
              className="group overflow-hidden transition-all hover:shadow-lg hover:shadow-primary/20"
            >
              <div className="relative">
                <img
                  src={game.image || "/placeholder.svg"}
                  alt={game.title}
                  className="h-32 w-full object-cover transition-transform group-hover:scale-105"
                />
                {game.trending && (
                  <Badge className="absolute right-1 top-1 text-xs bg-primary text-primary-foreground">
                    <TrendingUp className="mr-1 h-2 w-2" />
                    Hot
                  </Badge>
                )}
              </div>
              <CardHeader className="p-3 pb-2">
                <CardTitle className="text-sm text-balance leading-tight">{game.title}</CardTitle>
                <div className="flex items-center justify-between text-xs text-muted-foreground">
                  <div className="flex items-center">
                    <Users className="mr-1 h-3 w-3" />
                    {game.players}
                  </div>
                  <div className="flex items-center">
                    <Star className="mr-1 h-3 w-3 fill-yellow-400 text-yellow-400" />
                    {game.rating}
                  </div>
                </div>
              </CardHeader>
              <CardContent className="p-3 pt-0">
                <Button className="w-full h-8" size="sm">
                  <Download className="mr-1 h-3 w-3" />
                  Get Script
                </Button>
              </CardContent>
            </Card>
          ))}
        </div>

        {filteredGames.length === 0 && (
          <div className="text-center py-8">
            <Gamepad2 className="mx-auto h-8 w-8 text-muted-foreground mb-2" />
            <h3 className="text-base font-semibold mb-1">No games found</h3>
            <p className="text-sm text-muted-foreground">Try adjusting your search or filter criteria.</p>
          </div>
        )}
      </main>

      {/* Footer */}
      <footer className="border-t border-border bg-card mt-8">
        <div className="container mx-auto px-4 py-4">
          <div className="text-center">
            <div className="flex items-center justify-center space-x-2 mb-2">
              <Gamepad2 className="h-4 w-4 text-primary" />
              <span className="text-sm font-semibold">Roblox Game Hub</span>
            </div>
            <p className="text-xs text-muted-foreground">
              Discover and play the best Roblox games. Built for gamers, by gamers.
            </p>
          </div>
        </div>
      </footer>
    </div>
  )
}