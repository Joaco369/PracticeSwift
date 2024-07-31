//
//  Model.swift
//  ListsGrids
//
//  Created by Joaquin Villarreal on 06/04/2024.
//

import Foundation

struct Model: Identifiable {
    let id = UUID()
    let emoji: String
    let nombre: String
    let description: String
}

let lista: [Model] = [
    Model(
           emoji: "🙋🏼‍♂️",
           nombre: "Mano alzada",
           description: "Persona que levanta la mano para preguntar."),
       Model(
           emoji: "🥑",
           nombre: "Aguacate",
           description: "El aguacate es un fruto exótico carnoso que se obtiene del árbol tropical del mismo nombre. En algunas partes de América del Sur se conoce como Palta.."),
       Model(
           emoji: "🍕",
           nombre: "Pizza",
           description: "Comida chatarra creada en Italia."),
       Model(
           emoji: "🧩",
           nombre: "Pieza de rompecabezas",
           description: "Los rompecabezas o puzzles son piezas comúnmente planas que combinadas correctamente forman una figura, un objeto o una escena. ... Por diversión, entretenimiento o como una forma de relajarse"),
       Model(
           emoji: "🗽",
           nombre: "Estatua de la Libertad",
           description: "Estatua ubicada en Nuva York."),
    Model(
           emoji: "🙋🏼‍♂️",
           nombre: "Mano alzada",
           description: "Persona que levanta la mano para preguntar."),
       Model(
           emoji: "🥑",
           nombre: "Aguacate",
           description: "El aguacate es un fruto exótico carnoso que se obtiene del árbol tropical del mismo nombre. En algunas partes de América del Sur se conoce como Palta.."),
       Model(
           emoji: "🍕",
           nombre: "Pizza",
           description: "Comida chatarra creada en Italia."),
       Model(
           emoji: "🧩",
           nombre: "Pieza de rompecabezas",
           description: "Los rompecabezas o puzzles son piezas comúnmente planas que combinadas correctamente forman una figura, un objeto o una escena. ... Por diversión, entretenimiento o como una forma de relajarse"),
       Model(
           emoji: "🗽",
           nombre: "Estatua de la Libertad",
           description: "Estatua ubicada en Nuva York."),
    Model(
           emoji: "🙋🏼‍♂️",
           nombre: "Mano alzada",
           description: "Persona que levanta la mano para preguntar."),
       Model(
           emoji: "🥑",
           nombre: "Aguacate",
           description: "El aguacate es un fruto exótico carnoso que se obtiene del árbol tropical del mismo nombre. En algunas partes de América del Sur se conoce como Palta.."),
       Model(
           emoji: "🍕",
           nombre: "Pizza",
           description: "Comida chatarra creada en Italia."),
       Model(
           emoji: "🧩",
           nombre: "Pieza de rompecabezas",
           description: "Los rompecabezas o puzzles son piezas comúnmente planas que combinadas correctamente forman una figura, un objeto o una escena. ... Por diversión, entretenimiento o como una forma de relajarse"),
       Model(
           emoji: "🗽",
           nombre: "Estatua de la Libertad",
           description: "Estatua ubicada en Nuva York."),
    
]
